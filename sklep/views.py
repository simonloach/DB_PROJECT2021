# from django.shortcuts import render

from django.http import HttpResponse
from django.shortcuts import render
from sklep.models import Product


def index(request):
    return render(request, 'sklep/index.html', Product)