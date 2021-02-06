# from django.shortcuts import render
from sklep import database
from django.http import HttpResponse
from django.shortcuts import render
from sklep.models import Product, Categorie
from .forms import RegisterForm
from .forms import LoginForm


def index(request):

    top_products = Product.objects.all()
    parent_categories = Categorie.objects.all().filter(parent_cid = None)
    child_categories = database.getFirst2LevelsOfCat()
    toddler_categories = database.getToddlerCategories()
    context = {'top_products': top_products, 'parent_categories': parent_categories,
		'child_categories': child_categories, 'toddler_categories': toddler_categories}    
    return render(request, 'sklep/index.html', context)

def register(request):
    registerForm = RegisterForm()
    loginForm = LoginForm()
    context = {'registerForm': registerForm, 'loginForm':loginForm}
    return render(request, 'sklep/register.html', context)

def base(request):
    return render(request, 'sklep/base.html')
    
