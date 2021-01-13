# from django.shortcuts import render

from django.http import HttpResponse
from django.shortcuts import render
from sklep.models import Product


def index(request):
    top_products = Product.objects.all()[:15]
    context = {'top_products': top_products}
    return render(request, 'sklep/index.html', context)

def base(request):
    return render(request, 'sklep/base.html')
    
