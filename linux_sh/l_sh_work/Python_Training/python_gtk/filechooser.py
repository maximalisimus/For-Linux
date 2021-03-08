#!/usr/bin/env python3

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk as gtk

class MainWindow(gtk.Window):
	
	def __init__(self):
		gtk.Window.__init__(self,title="")
		self.set_border_width(30)
		layout = gtk.Box(spacing=6)
		self.add(layout)
		
		button = gtk.Button("choose File")
		button.connect("clicked", self.on_file_clicked)
		layout.add(button)
		
	def on_file_clicked(self, widget):
		filechooserdialog = gtk.FileChooserDialog(title="Open...",
             parent=None,
             action=gtk.FileChooserAction.OPEN)
		# gtk.FILE_CHOOSER_ACTION_OPEN
		# gtk.FILE_CHOOSER_ACTION_SAVE
		# gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER
		# gtk.FILE_CHOOSER_ACTION_CREATE_FOLDER
		filechooserdialog.add_buttons("_Open", gtk.ResponseType.OK)
		filechooserdialog.add_buttons("_Cancel", gtk.ResponseType.CANCEL)
		# _Open _Cancel _Save _Apply _Ok
		filechooserdialog.set_default_response(gtk.ResponseType.OK)
		response = filechooserdialog.run()
		if response == gtk.ResponseType.OK:
			print("File selected: %s" % filechooserdialog.get_filename())
		filechooserdialog.destroy()
		
		# dialog = gtk.FileChooserDialog(title = "Open file ...", 
		#								parent = None, action = gtk.FileChooserAction.OPEN, 
		#								buttons = ("_Open", gtk.ResponseType.OK, "_Cancel", gtk.ResponseType.CANCEL))
		# response = dialog.run()
		# if response == gtk.ResponseType.CANCEL:
		#	print("Dialog a didn't to file choose")
		# elif response == gtk.ResponseType.OK:
		#	print("The button to clikced is Open")
		#	print("File selected:", dialog.get_filename())
		# dialog.destroy()


window = MainWindow()
window.connect("delete-event", gtk.main_quit)
window.show_all()
gtk.main()
