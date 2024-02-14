from django.contrib import admin
from .models import Slide,OpenSlide

# Register your models here.
# class SlideAdmin(admin.ModelAdmin):
    

admin.site.register(Slide)
admin.site.register(OpenSlide)