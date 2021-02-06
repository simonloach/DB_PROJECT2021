from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('base/', views.base, name='base'),
    path('register/', views.register, name='register'),
    path('product/<int:product_id>/', views.product, name='product')
]
