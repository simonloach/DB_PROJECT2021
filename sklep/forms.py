from django import forms

class RegisterForm(forms.Form):
    # login = forms.CharField(max_length=100)
    
    name = forms.CharField(label='Name', max_length=100)
    name.widget.attrs.update({'class': 'form-control'})
    email = forms.CharField(label='Email', max_length=100)
    #email.widget.attrs.update({'class': 'form-control'})
    password = forms.CharField(label='Password', max_length=100, widget=forms.PasswordInput())
    #password.widget.attrs.update({'class': 'form-control'})
    # surname = forms.CharField(max_length=100)
    # city = forms.CharField(max_length=100)
    # region = forms.CharField(max_length=100)
    # zip_code = forms.CharField(max_length=100)
    # street = forms.CharField(max_length=100)
    # building_no = forms.IntegerField()
    # apart_no = forms.IntegerField()
    # phone = forms.CharField(max_length=100)

        
    def __init__(self, *args, **kwargs):
        super(RegisterForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            field.widget.attrs.update({'class': 'form-control'})
    
class LoginForm(forms.Form):
    login = forms.CharField(max_length=100)
    email = forms.CharField(max_length=100)
    password = forms.CharField(max_length=100)
    