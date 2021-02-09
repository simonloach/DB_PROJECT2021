from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('base/', views.base, name='base'),
    path('register/', views.register, name='register'),
    path('login/', views.login, name='login'),
    path('register/user/', views.register, name='register'),
    path('product/<int:product_id>/', views.product, name='product'),
    path('category/<int:cat_id>/', views.category, name='category'),
    path('category/<int:cat_id>/<int:page>', views.category, name='category'),
    path('details/<int:prod_id>/', views.detail, name='detail'),
    path('search/', views.search, name='search'),
    path('basket/', views.basket, name='basket'),
    path('thanks/', views.thanks, name='thanks')
]   
