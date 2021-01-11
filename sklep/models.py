# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Cart(models.Model):
    cart_id = models.IntegerField(primary_key=True)
    client = models.ForeignKey('Client', models.DO_NOTHING, blank=True, null=True)
    pid = models.IntegerField(blank=True, null=True)
    quantity = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'cart'


class Categorie(models.Model):
    cid = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=100)
    parent_cid = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'categorie'


class Client(models.Model):
    client_id = models.IntegerField(primary_key=True)
    login = models.CharField(max_length=100)
    sha_pass = models.CharField(db_column='SHA_pass', max_length=100)  # Field name made lowercase.
    name = models.CharField(max_length=100)
    surname = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    region = models.CharField(max_length=100, blank=True, null=True)
    zip_code = models.CharField(max_length=100)
    street = models.CharField(max_length=100)
    building_no = models.IntegerField()
    apart_no = models.IntegerField(blank=True, null=True)
    phone = models.IntegerField()
    email = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'client'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Manufacturer(models.Model):
    manufacturer_id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'manufacturer'


class ManufacturersCategorie(models.Model):
    manufacturers_categories = models.IntegerField(primary_key=True)
    manufacturer = models.ForeignKey(Manufacturer, models.DO_NOTHING, blank=True, null=True)
    cid = models.ForeignKey(Categorie, models.DO_NOTHING, db_column='cid', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'manufacturers_categorie'


class Order(models.Model):
    oid = models.IntegerField(primary_key=True)
    client = models.ForeignKey(Client, models.DO_NOTHING)
    order_placed_date = models.DateTimeField()
    order_taken_date = models.DateTimeField(blank=True, null=True)
    shipping_date = models.DateTimeField(blank=True, null=True)
    order_fulfilment_date = models.DateTimeField(blank=True, null=True)
    order_taken = models.BooleanField(blank=True, null=True)
    order_fulfilled = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'order'


class OrderedProduct(models.Model):
    ordered_product_id = models.IntegerField(primary_key=True)
    oid = models.ForeignKey(Order, models.DO_NOTHING, db_column='oid', blank=True, null=True)
    pid = models.ForeignKey('Product', models.DO_NOTHING, db_column='pid', blank=True, null=True)
    product_quantity = models.IntegerField()
    product_price = models.DecimalField(max_digits=65535, decimal_places=65535)

    class Meta:
        managed = False
        db_table = 'ordered_product'


class Product(models.Model):
    pid = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    image_source = models.CharField(max_length=100, blank=True, null=True)
    manufacturers_categories = models.ForeignKey(ManufacturersCategorie, models.DO_NOTHING, db_column='manufacturers_categories', blank=True, null=True)
    price_gross = models.DecimalField(max_digits=65535, decimal_places=65535)
    vat_tax = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    no_instock = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'product'
