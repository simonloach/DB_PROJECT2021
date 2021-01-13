# from django.shortcuts import render

from django.http import HttpResponse
from django.shortcuts import render


def index(request):
    return render(request, 'sklep/index.html')

def base(request):
    return render(request, 'sklep/base.html')