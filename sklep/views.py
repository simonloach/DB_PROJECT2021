# from django.shortcuts import render

from django.http import HttpResponse
from django.shortcuts import render
from sklep.models import Product


def index(request):
    top_products = Product.objects.all()[:5]
    context = {'top_products': top_products}
    return render(request, 'sklep/index.html', context)