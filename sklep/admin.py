from django.contrib import admin

# Register your models here.

from .models import Categorie, Client,Manufacturer,ManufacturersCategorie,Order,OrderedProduct,Product

admin.site.register(Categorie)
admin.site.register(Client)
admin.site.register(Manufacturer)
admin.site.register(ManufacturersCategorie)
admin.site.register(Order)
admin.site.register(OrderedProduct)
admin.site.register(Product)
