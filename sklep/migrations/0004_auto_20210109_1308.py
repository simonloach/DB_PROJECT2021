# Generated by Django 3.1.5 on 2021-01-09 13:08

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sklep', '0003_authgroup_authgrouppermissions_authpermission_authuser_authusergroups_authuseruserpermissions_catego'),
    ]

    operations = [
        migrations.DeleteModel(
            name='AuthGroup',
        ),
        migrations.DeleteModel(
            name='AuthGroupPermissions',
        ),
        migrations.DeleteModel(
            name='AuthPermission',
        ),
        migrations.DeleteModel(
            name='AuthUser',
        ),
        migrations.DeleteModel(
            name='AuthUserGroups',
        ),
        migrations.DeleteModel(
            name='AuthUserUserPermissions',
        ),
        migrations.DeleteModel(
            name='Categorie',
        ),
        migrations.DeleteModel(
            name='Client',
        ),
        migrations.DeleteModel(
            name='DjangoAdminLog',
        ),
        migrations.DeleteModel(
            name='DjangoContentType',
        ),
        migrations.DeleteModel(
            name='DjangoMigrations',
        ),
        migrations.DeleteModel(
            name='DjangoSession',
        ),
        migrations.DeleteModel(
            name='Manufacturer',
        ),
        migrations.DeleteModel(
            name='ManufacturersCategorie',
        ),
        migrations.DeleteModel(
            name='Order',
        ),
        migrations.DeleteModel(
            name='OrderedProduct',
        ),
        migrations.DeleteModel(
            name='Product',
        ),
    ]