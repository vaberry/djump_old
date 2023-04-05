from django.shortcuts import render, redirect
from django.views.generic.base import View, TemplateView

# class Home(TemplateView):
#     template_name='home.html'

class Home(View):
    def get(self, request, *args, **kwargs):
        if request.method == "GET":
            #delete pass and add code here
            pass
        return render(request, 'home.html')