from django import forms
from django.core.validators import MinValueValidator, MaxValueValidator


COUNTRIES = [
    ('pl', 'Poland'),
    ('else', 'Not Poland'),
]

class RegisterForm(forms.Form):
    name = forms.CharField(label='Name', max_length=100)
    name.widget.attrs.update({'class': 'form-control'})

    surname = forms.CharField(label='Surname', max_length=100)
    surname.widget.attrs.update({'class': 'form-control'})

    email = forms.EmailField(label='Email', max_length=100)
    email.widget.attrs.update({'class': 'form-control'})

    password = forms.CharField(label='Password', max_length=100, widget=forms.PasswordInput())
    password.widget.attrs.update({'class': 'form-control'})

    confirm_password = forms.CharField(label='Confirm Password', max_length=100, widget=forms.PasswordInput())
    confirm_password.widget.attrs.update({'class': 'form-control'})

    phone = forms.IntegerField(label='Phone No.', validators=[MinValueValidator(100000000), MaxValueValidator(999999999)], help_text='xxx-xxx-xxx is equal to xxxxxxxxx')
    phone.widget.attrs.update({'class': 'form-control'})

    country = forms.ChoiceField(label='Country', choices=COUNTRIES)
    country.widget.attrs.update({'class': 'form-control'})

    city = forms.CharField(label='City', max_length=100)
    city.widget.attrs.update({'class': 'form-control'})

    zip_code = forms.CharField(label='Zip Code', max_length=100,help_text='No dashes xx-xxx is equal to xxxxx')
    zip_code.widget.attrs.update({'class': 'form-control'})

    address = forms.CharField(label='Address', max_length=100)
    address.widget.attrs.update({'class': 'form-control'})

    apart_no = forms.IntegerField(label='Apt No.', validators=[MinValueValidator(1), MaxValueValidator(1000)], required=False)
    apart_no.widget.attrs.update({'class': 'form-control'})

    

    def clean(self):
        cleaned_data = super(RegisterForm, self).clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")

        if password != confirm_password:
            raise forms.ValidationError(
                "Password and confirm password does not match"
            )

 
class LoginForm(forms.Form):
    email = forms.EmailField(label='Email', max_length=100)
    email.widget.attrs.update({'class': 'form-control'})

    password = forms.CharField(label='Password', max_length=100, widget=forms.PasswordInput())
    password.widget.attrs.update({'class': 'form-control'})
    