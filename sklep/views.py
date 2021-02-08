# from django.shortcuts import render
from sklep import database
from django.http import HttpResponse, Http404
from django.shortcuts import render, redirect
from sklep.models import Product, Categorie, ManufacturersCategorie, Client
from .forms import RegisterForm
from .forms import LoginForm


def index(request):

    top_products = database.getBestSelling(1000, 25)
    parent_categories = Categorie.objects.all().filter(parent_cid = None)
    child_categories = database.getFirst2LevelsOfCat()
    toddler_categories = database.getToddlerCategories()
    context = {'top_products': top_products, 'parent_categories': parent_categories,
		'child_categories': child_categories, 'toddler_categories': toddler_categories}    
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

            num_results = Client.objects.filter(email = email).count()
            if num_results == 0:
                Client.objects.create(
                sha_pass = password,
                email = email,
                name=name,
                surname = surname,
                country = country,
                city = city,
                zip_code = zip_code,
                street = address,
                phone = phone,
                )


            return redirect('/thanks/')

    registerForm = RegisterForm()
    loginForm = LoginForm()
    context = {'registerForm': registerForm, 'loginForm':loginForm}
    return render(request, 'sklep/register.html', context)


def base(request):
    return render(request, 'sklep/base.html')
    

def product(request, product_id):
    try:
        product = Product.objects.get(pid=product_id)
    except Product.DoesNotExist:
        raise Http404("Product does not exist")
    return render(request, 'sklep/product.html', {'product': product, 'product_id':product_id})

def category(request, cat_id):
    try:
        category = Categorie.objects.get(cid=cat_id)
        parent_categories_tree = []
        parent_categories = Categorie.objects.all().filter(parent_cid = None)
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
    return render(request, 'sklep/category.html', {'category': category, 'parent_categories': parent_categories,
		'child_categories': child_categories, 'toddler_categories': toddler_categories, 'category_products':category_products,
        'cat_id':cat_id, 'parent_categories_tree':parent_categories_tree, 'parent':parent })

def detail(request, prod_id):
    try:
        product = Product.objects.get(pid=prod_id)
        category = ManufacturersCategorie.objects.get(manufacturers_categorie_id=product.manufacturers_categorie_id).cid
        parent_categories_tree = []
        parent_categories = Categorie.objects.all().filter(parent_cid = None)
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
		'child_categories': child_categories, 'toddler_categories': toddler_categories, 'category_products':category_products,
        'product':product, 'parent_categories_tree':parent_categories_tree, 'parent':parent })

def search(request):
    try:
        phrase = request.GET.get('phrase', '')
        products = database.getSearchByName(phrase)
        parent_categories = Categorie.objects.all().filter(parent_cid = None)
        child_categories = database.getFirst2LevelsOfCat()
        toddler_categories = database.getToddlerCategories()
    except Categorie.DoesNotExist:
        raise Http404("Category does not exist")
    return render(request, 'sklep/search.html', {'parent_categories': parent_categories,
		'child_categories': child_categories, 'toddler_categories': toddler_categories,
        'phrase':phrase, 'products':products})