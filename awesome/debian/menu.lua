-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

module("debian.menu")

Debian_menu = {}

Debian_menu["Debian_Aide"] = {
	{"Info", "x-terminal-emulator -e ".."info"},
	{"Xman","xman"},
}
Debian_menu["Debian_Applications_Accessibilité"] = {
	{"Xmag","xmag"},
}
Debian_menu["Debian_Applications_Dessin_et_image"] = {
	{"X Window Snapshot","xwd | xwud"},
}
Debian_menu["Debian_Applications_Éditeurs"] = {
	{"Nano", "x-terminal-emulator -e ".."/bin/nano","/usr/share/nano/nano-menu.xpm"},
}
Debian_menu["Debian_Applications_Émulateurs_de_terminaux"] = {
	{"XTerm","xterm","/usr/share/pixmaps/xterm-color_32x32.xpm"},
	{"XTerm (Unicode)","uxterm","/usr/share/pixmaps/xterm-color_32x32.xpm"},
}
Debian_menu["Debian_Applications_Interpréteurs_de_commandes"] = {
	{"Bash", "x-terminal-emulator -e ".."/bin/bash --login"},
	{"Python (v2.5)", "x-terminal-emulator -e ".."/usr/bin/python2.5","/usr/share/pixmaps/python2.5.xpm"},
	{"Sh", "x-terminal-emulator -e ".."/bin/sh --login"},
}
Debian_menu["Debian_Applications_Lecteurs"] = {
	{"Xditview","xditview"},
}
Debian_menu["Debian_Applications_Programmation"] = {
	{"ccmake", "x-terminal-emulator -e ".."/usr/bin/ccmake","/usr/share/pixmaps/cmake.xpm"},
}
Debian_menu["Debian_Applications_Réseau_Communication"] = {
	{"Mutt", "x-terminal-emulator -e ".."/usr/bin/mutt","/usr/share/pixmaps/mutt.xpm"},
	{"Telnet", "x-terminal-emulator -e ".."/usr/bin/telnet"},
	{"Xbiff","xbiff"},
}
Debian_menu["Debian_Applications_Réseau_Navigateurs_web"] = {
	{"w3m", "x-terminal-emulator -e ".."/usr/bin/w3m /usr/share/doc/w3m/MANUAL.html"},
}
Debian_menu["Debian_Applications_Réseau"] = {
	{ "Communication", Debian_menu["Debian_Applications_Réseau_Communication"] },
	{ "Navigateurs web", Debian_menu["Debian_Applications_Réseau_Navigateurs_web"] },
}
Debian_menu["Debian_Applications_Sciences_Mathématiques"] = {
	{"Bc", "x-terminal-emulator -e ".."/usr/bin/bc"},
	{"Dc", "x-terminal-emulator -e ".."/usr/bin/dc"},
	{"Xcalc","xcalc"},
}
Debian_menu["Debian_Applications_Sciences"] = {
	{ "Mathématiques", Debian_menu["Debian_Applications_Sciences_Mathématiques"] },
}
Debian_menu["Debian_Applications_Système_Administration"] = {
	{"Aptitude", "x-terminal-emulator -e ".."/usr/bin/aptitude"},
	{"Debian Task selector", "x-terminal-emulator -e ".."su-to-root -c tasksel"},
	{"Editres","editres"},
	{"reportbug", "x-terminal-emulator -e ".."/usr/bin/reportbug --exit-prompt"},
	{"Xclipboard","xclipboard"},
	{"Xfontsel","xfontsel"},
	{"Xkill","xkill"},
	{"Xrefresh","xrefresh"},
}
Debian_menu["Debian_Applications_Système_Matériel"] = {
	{"Xvidtune","xvidtune"},
}
Debian_menu["Debian_Applications_Système_Paramétrage_de_la_langue"] = {
	{"Belarusian environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l be"},
	{"Bulgarian environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l bg"},
	{"Catalan environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l ca"},
	{"Danish environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l da"},
	{"French environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l fr"},
	{"German environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l de"},
	{"Japanese environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l ja"},
	{"Korean environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l ko"},
	{"Lithuanian environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l lt"},
	{"Macedonian environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l mk"},
	{"Native Language Environment","/usr/bin/tklanguage"},
	{"Native Language Environment - remove", "x-terminal-emulator -e ".."/usr/bin/set-language-env -r"},
	{"Polish environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l pl"},
	{"Russian environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l ru"},
	{"Serbian environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l sr"},
	{"Spanish environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l es"},
	{"Thai environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l th"},
	{"Turkish environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l tr"},
	{"Ukrainian environment", "x-terminal-emulator -e ".."/usr/bin/set-language-env -l uk"},
}
Debian_menu["Debian_Applications_Système_Surveillance"] = {
	{"Top", "x-terminal-emulator -e ".."/usr/bin/top"},
	{"Xconsole","xconsole -file /dev/xconsole"},
	{"Xev","x-terminal-emulator -e xev"},
	{"Xload","xload"},
}
Debian_menu["Debian_Applications_Système"] = {
	{ "Administration", Debian_menu["Debian_Applications_Système_Administration"] },
	{ "Matériel", Debian_menu["Debian_Applications_Système_Matériel"] },
	{ "Paramétrage de la langue", Debian_menu["Debian_Applications_Système_Paramétrage_de_la_langue"] },
	{ "Surveillance", Debian_menu["Debian_Applications_Système_Surveillance"] },
}
Debian_menu["Debian_Applications"] = {
	{ "Accessibilité", Debian_menu["Debian_Applications_Accessibilité"] },
	{ "Dessin et image", Debian_menu["Debian_Applications_Dessin_et_image"] },
	{ "Éditeurs", Debian_menu["Debian_Applications_Éditeurs"] },
	{ "Émulateurs de terminaux", Debian_menu["Debian_Applications_Émulateurs_de_terminaux"] },
	{ "Interpréteurs de commandes", Debian_menu["Debian_Applications_Interpréteurs_de_commandes"] },
	{ "Lecteurs", Debian_menu["Debian_Applications_Lecteurs"] },
	{ "Programmation", Debian_menu["Debian_Applications_Programmation"] },
	{ "Réseau", Debian_menu["Debian_Applications_Réseau"] },
	{ "Sciences", Debian_menu["Debian_Applications_Sciences"] },
	{ "Système", Debian_menu["Debian_Applications_Système"] },
}
Debian_menu["Debian_Jeux_Jouets"] = {
	{"Oclock","oclock"},
	{"Xclock (analog)","xclock -analog"},
	{"Xclock (digital)","xclock -digital -update 1"},
	{"Xeyes","xeyes"},
	{"Xlogo","xlogo"},
}
Debian_menu["Debian_Jeux"] = {
	{ "Jouets", Debian_menu["Debian_Jeux_Jouets"] },
}
Debian_menu["Debian"] = {
	{ "Aide", Debian_menu["Debian_Aide"] },
	{ "Applications", Debian_menu["Debian_Applications"] },
	{ "Jeux", Debian_menu["Debian_Jeux"] },
}
