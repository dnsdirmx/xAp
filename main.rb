require 'tk'

root = TkRoot.new {title "xAp GUI for create_ap"}
TkLabel.new (root) do
	text "initial"
	pack { side 'left'}
end
Tk.mainloop
