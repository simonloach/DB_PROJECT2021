# from django.shortcuts import render
from sklep import database
from django.http import HttpResponse, Http404
from django.shortcuts import render, redirect
from sklep.models import Manufacturer, Product, Categorie, ManufacturersCategorie, Client, Cart, Order, OrderedProduct
from .forms import RegisterForm
from .forms import LoginForm
from datetime import datetime
from django.contrib.auth.hashers import check_password, make_password

def index(request):

    sql = database.getBestSelling(100, 100)
    temp = []

    for product in sql:
        temp.append(database.DummyProduct(product))
    context = {}
    context['top_products'] = temp  # Product.objects.all()
    context['parent_categories'] = Categorie.objects.all().filter(parent_cid=None)
    context['child_categories'] = database.getFirst2LevelsOfCat()
    context['toddler_categories'] = database.getToddlerCategories()

    if request.session.get('logged_in'):
        context['user_session'] = request.session['client_id']
        cli_id = int(request.session['client_id'])
        user_carts = Cart.objects.filter(client=cli_id)
        total = 0
        for cart in user_carts:
            total += cart.quantity
        context['total'] = total

    else:
        context['total'] = 0

    return render(request, 'sklep/index.html', context)


def register(request):
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():

            name = form.cleaned_data['name']
            surname = form.cleaned_data['surname']
            email = form.cleaned_data['email']
            password = form.cleaned_data['password']
            country = form.cleaned_data['country']
            city = form.cleaned_data['city']
            zip_code = form.cleaned_data['zip_code']
            address = form.cleaned_data['address']
            phone = form.cleaned_data['phone']
            apart_no = form.cleaned_data['apart_no']

            if not apart_no:
                apart_no = 1
            num_results = Client.objects.filter(email=email).count()
            if num_results == 0:
                password = make_password(password)
                Client.objects.create(
                    sha_pass=password,
                    email=email,
                    name=name,
                    surname=surname,
                    country=country,
                    city=city,
                    zip_code=zip_code,
                    street=address,
                    phone=phone,
                    apart_no=apart_no,
                )

            return redirect('/thanks/')

    registerForm = RegisterForm()
    loginForm = LoginForm()
    context = {'registerForm': registerForm, 'loginForm': loginForm}
    return render(request, 'sklep/register.html', context)


def base(request):
    return render(request, 'sklep/base.html')

def checkout(request):
    user_carts = Cart.objects.filter(client=request.session['client_id'])
    final, no_products, total_price = prepare_data(user_carts)

    context = {'data': final, 'no_products': no_products, 'total_price': total_price}
    return render(request, 'sklep/checkout.html', context)

def product(request, product_id):
    try:
        product = Product.objects.get(pid=product_id)
    except Product.DoesNotExist:
        raise Http404("Product does not exist")
    return render(request, 'sklep/product.html', {'product': product, 'product_id': product_id})


def category(request, cat_id):
    try:
        context = {}
        category = Categorie.objects.get(cid=cat_id)
        context['category'] = category
        context['manufacturers'] = Manufacturer.objects.all()
        parent_categories_tree = []
        context['parent_categories'] = Categorie.objects.all().filter(parent_cid=None)
        context['child_categories'] = database.getFirst2LevelsOfCat()
        context['toddler_categories'] = database.getToddlerCategories()
        context['parent'] = category
        products = database.getToddlerProducts(cat_id)
        temp = []
        for product in products:
            temp.append(database.DummyProduct(product))

        context['category_products'] = temp
        if category.parent_cid:
            parent_categories_tree.append(Categorie.objects.get(cid=category.parent_cid))
            while parent_categories_tree[0].parent_cid:
                parent_categories_tree.insert(0, Categorie.objects.get(cid=parent_categories_tree[-1].parent_cid))
            context['parent'] = parent_categories_tree[0]

        context['parent_categories_tree'] = parent_categories_tree
        context['cat_id'] = cat_id

        if request.session.get('logged_in'):
            context['user_session'] = request.session['client_id']
            cli_id = int(request.session['client_id'])
            user_carts = Cart.objects.filter(client=cli_id)
            total = 0
            for cart in user_carts:
                total += cart.quantity
            context['total'] = total

        else:
            context['total'] = 0

    except Categorie.DoesNotExist:
        raise Http404("Category does not exist")
    return render(request, 'sklep/category.html', context)


def detail(request, prod_id):
    try:
        product = Product.objects.get(pid=prod_id)
        category = ManufacturersCategorie.objects.get(manufacturers_categorie_id=product.manufacturers_categorie_id).cid
        parent_categories_tree = []
        parent_categories = Categorie.objects.all().filter(parent_cid=None)
        child_categories = database.getFirst2LevelsOfCat()
        toddler_categories = database.getToddlerCategories()
        parent = category
        category_products = Product.objects.all()
        if category.parent_cid:
            parent_categories_tree.append(Categorie.objects.get(cid=category.parent_cid))
            while parent_categories_tree[0].parent_cid:
                parent_categories_tree.insert(0, Categorie.objects.get(cid=parent_categories_tree[-1].parent_cid))
            parent = parent_categories_tree[0]
    except Categorie.DoesNotExist:
        raise Http404("Category does not exist")
    return render(request, 'sklep/detail.html', {'category': category, 'parent_categories': parent_categories,
                                                 'child_categories': child_categories,
                                                 'toddler_categories': toddler_categories,
                                                 'category_products': category_products,
                                                 'product': product, 'parent_categories_tree': parent_categories_tree,
                                                 'parent': parent})


def search(request):
    try:
        phrase = request.GET.get('phrase', '')
        products = database.getSearchByName(phrase)
        parent_categories = Categorie.objects.all().filter(parent_cid=None)
        child_categories = database.getFirst2LevelsOfCat()
        toddler_categories = database.getToddlerCategories()
    except Categorie.DoesNotExist:
        raise Http404("Category does not exist")
    return render(request, 'sklep/search.html', {'parent_categories': parent_categories,
                                                 'child_categories': child_categories,
                                                 'toddler_categories': toddler_categories,
                                                 'phrase': phrase, 'products': products})


def thanks(request):
    return render(request, 'sklep/thanks.html')

def buy(request):
    cli_id = request.session['client_id']
    new_order = Order(client_id=cli_id, order_placed_date=datetime.now())
    new_order.save()

    user_carts = Cart.objects.filter(client=request.session['client_id'])

    for item in user_carts:
        prod = Product.objects.get(pid=item.pid.pid)

        order_product_quantity = item.quantity
        order_product_price = prod.price_gross

        OrderedProduct.objects.create(oid=new_order, pid=prod, product_quantity=order_product_quantity, product_price=order_product_price)
    
    user_carts.delete()

    return render(request, 'sklep/buy.html')


def login(request):
    loginForm = LoginForm(request.POST)
    context = {'loginForm': loginForm}

    if request.method == "POST":
        if loginForm.is_valid():
            try:
                account = Client.objects.get(email=request.POST['email'])
                if check_password(request.POST['password'], account.sha_pass): #(account.sha_pass == request.POST['password']):
                    request.session['client_id'] = account.client_id
                    request.session['logged_in'] = True
                    request.session.set_expiry(3000)
                    return redirect('/')
                else:
                    request.session['login_status'] = False
                    request.session['login_message'] = 'Wrong credentials! 3'
            except Client.DoesNotExist:
                request.session['login_status'] = False
                request.session['login_message'] = 'Wrong credentials! 2'
        else:
            request.session['login_status'] = False
            request.session['login_message'] = 'Wrong credentials! 1'
    return render(request, 'sklep/login.html', context)


def basket(request):
    if request.method == 'POST':

        if request.POST['client_id'] != '/':

            cli_id = int(request.POST['client_id'])
            prod_id = int(request.POST['product_id'])
            cli_obj = Client.objects.get(client_id=cli_id)
            try:

                user_cart = Cart.objects.all().filter(client_id=cli_id, pid=Product.objects.get(pid=prod_id))
                if user_cart:
                    for cart in user_cart:
                        cart.quantity += 1
                        cart.save()
                else:
                    new_cart = Cart(client=cli_obj, pid=Product.objects.get(pid=prod_id), quantity=1)
                    new_cart.save()

            except Cart.DoesNotExist:
                new_cart = Cart(client=cli_obj, pid=prod_id, quantity=1)

            user_carts = Cart.objects.filter(client=cli_id)
            final, no_products, total_price = prepare_data(user_carts)

            context = {'data': final, 'no_products': no_products, 'total_price':total_price}
            return render(request, 'sklep/basket.html', context)
        else:
            loginForm = LoginForm(request.POST)
            context = {'loginForm': loginForm}
            return redirect('/login', context)
    if request.method == 'GET':
        if request.session.get('logged_in'):
            user_carts = Cart.objects.filter(client=request.session['client_id'])
            final, no_products, total_price = prepare_data(user_carts)

            context = {'data': final, 'no_products': no_products, 'total_price': total_price}
            return render(request, 'sklep/basket.html', context)
        else:
            loginForm = LoginForm(request.POST)
            context = {'loginForm': loginForm}
            return redirect('/login',context)


def delete(request, pid):
    cli_id = request.session['client_id']
    database.deleteCart(cli_id, pid)
    return redirect('/basket')


def update(request):
    quantity = request.POST.getlist('quantity')
    prod_id = request.POST.getlist('pid')

    cli_id = request.session['client_id']
    for n,qua in  enumerate(quantity):
        prod = int(prod_id[n])
        quant = int(qua)
        if quant > 0:
            database.updateQuantity(cli_id, prod, quant)
            HttpResponse(print(cli_id, prod, quant))
        else:
            database.deleteCart(cli_id,prod)

    return redirect('/basket')


def handle_session(request, context):
    if request.session.get('logged_in'):
        context['user_session'] = request.session['client_id']
    return context


def prepare_data(user_carts):
    final = []
    no_products = 0
    total = 0
    for cart in user_carts:
        temp_dict = {}
        prod = Product.objects.get(pid=cart.pid.pid)
        temp_dict['image_source'] = img_dir_list(prod)
        temp_dict['name'] = prod.name
        temp_dict['pid'] = prod.pid
        temp_dict['quantity'] = cart.quantity
        temp_dict['price_gross'] = prod.price_gross
        temp_dict['total'] = cart.quantity * prod.price_gross
        total += temp_dict['total']
        no_products += cart.quantity
        final.append(temp_dict)

    return final, no_products, total


def img_as_list(product):
    if product.image_source:
        return product.image_source.split(',')
    else: return ['img/no-image-found.png']

def img_dir_list(product):
    img_list = []
    for img in product.img_as_list():
        img_list.append("db_temp_img/"+str(product.pid)+"/"+img)
    if len(img_list) == 1: img_list.append(img_list[0])
    return img_list


