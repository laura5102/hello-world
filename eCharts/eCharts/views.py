# coding=utf-8
from django.shortcuts import render_to_response

def sankey(request):
    return render_to_response('sankey-product.html')
    
def eCharts(request):
    return render_to_response('eCharts.html')