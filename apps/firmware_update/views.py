import json
from django.http import HttpResponse
from django.shortcuts import render
from .models import Firmware

# Create your views here.
def index(request):
  return render(request, 'keycard_shell/firmware.html', context=None)

def fw_context(request):
  fw = Firmware.objects.last()

  fw_context = {
    "fw_path": fw.version + '/firmware.bin',
    "changelog_path": fw.version + '/changelog.md',
    "version": fw.version
    }

  return HttpResponse(json.dumps(fw_context), content_type='application/json')

