require 'tk'
require 'open3'

def startNetwork(name,password)
	strCmd =  'create_ap wlan1 wlan1 "' +  name + '"  "' + password + '" --daemon'
	puts strCmd
	stdin, stdout, stderr, status = Open3.popen3(strCmd)
	if not status.value == 0
		puts stdout.readlines
		puts stderr.readlines	

	else
		puts "[X] Ap created"
	end
	
end
def createAccessPointForm(parent)
	
	#get name
	lbAccessPointName = TkLabel.new(parent) do
		text "Access Point Name: "
		#pack('padx'=>10, 'pady'=>10, 'side'=>'left')	
		place('relx'=>0.0, 'rely'=>0.0)
	end
	
	tbAccessPointName = TkEntry.new(parent) do
		#pack('padx'=>10, 'pady'=>10, 'side'=>'left')	
		place('relx'=>0.5, 'rely'=>0.0)
	end
	
	defaultAPName = TkVariable.new
	tbAccessPointName.textvariable = defaultAPName	
	defaultAPName.value = "MyAccessPoint"

	#get password
	lbAccessPointPassphrase = TkLabel.new(parent) do
		text "Passphrase: "
		#pack('padx'=>10, 'pady'=>10, 'side'=>'left')	
		place('relx'=>0.0, 'rely'=>0.1)
	end
	tbAccessPointPassphrase = TkEntry.new(parent) do
		show "*"
		#pack('padx'=>10, 'pady'=>10, 'side'=>'left')	
		place('relx'=>0.5, 'rely'=>0.1)
	end
	defaultAPPassword = TkVariable.new
	tbAccessPointPassphrase.textvariable = defaultAPPassword
	defaultAPPassword.value = "12345678"
	


	btnStartNetwork = TkButton.new(parent) do
		text "Start"
	  	command (proc {startNetwork tbAccessPointName.get, tbAccessPointPassphrase.get })
  		place('relx'=>0.5, 'rely'=>0.2)
	end

end

def createNotebookOptions(root)
	n = Tk::Tile::Notebook.new(root)do
		height 256
		width 400
		pack('side' => 'top')
	end
	f1 = TkFrame.new(n)
	
	createAccessPointForm f1

	f2 = TkFrame.new(n)
	f3 = TkFrame.new(n)

	n.add f1, :text => 'New Ap'
	n.add f2, :text => 'Clients'
end

root = TkRoot.new {title "xAp GUI for create_ap"}
createNotebookOptions root

Tk.mainloop



