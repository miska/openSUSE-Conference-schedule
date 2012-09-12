all: schedule-final.html
	mkdir -p publish
	cp -r static publish
	cp $< publish/index.html

schedule-final.html: sed-rules tail.html tail.html schedule-head1.html schedule-head2.html in/Saturday-data.html in/Sunday-data.html in/Monday-data.html in/Tuesday-data.html
	cat schedule-head1.html in/*.css schedule-head2.html in/Saturday-data.html in/Sunday-data.html in/Monday-data.html in/Tuesday-data.html | sed -f sed-rules | cat - tail.html | sed "s|#DATE#|`date +%Y-%m-%d`|" > schedule-final.html

in/Saturday-tidy.html: in/Saturday.html
	sed -e 's|<td\ class="rShim"\ style="width:0;"></td>||' \
		 -e 's|<td\ class="hd"><p\ style="height:16px;">.</p></td>||g' \
		 -e 's|td\ class="hd"><p\ style="height:16px;">.</p></td>||g' \
		 -e 's|class="rShim"\ style="width:120px;"|class="rShim"\ @width@|' \
		 $< |	sed 's|class="rShim"\ style="[^"]*"|class="rShim"\ style="width: 13%%;"|g' \
		 | sed 's|class="rShim"\ @width@|class="rShim"\ style="width: 9%%;"|' \
		 | tidy -i -asxml -utf8 -w 0 - | sed \
		 -e 's|<table|<div\ id="saturday"\ class="tab-pane\ fade"><table|' \
		 -e 's|</table>|</table></div>|' > $@

in/Saturday-data.html: in/Saturday-tidy.html
	grep '\.tblGenFixed' $< | sed 's|td.s|td.sat-s|g' > in/Saturday.css
	sed -n '/\<table.*/,/<\/table>/ p' $< | sed -e 's|\([\ "]\)\(s[0-9]\+\)\([\ "]\)|\1sat-\2\3|g' > $@

in/Sunday-tidy.html: in/Sunday.html
	sed -e 's|<td\ class="rShim"\ style="width:0;"></td>||' \
		 -e 's|<td\ class="hd"><p\ style="height:16px;">.</p></td>||g' \
		 -e 's|class="rShim"\ style="width:120px;"|class="rShim"\ @width@|' \
		 $< |	sed 's|class="rShim"\ style="[^"]*"|class="rShim"\ style="width: 13%%;"|g' \
		 | sed 's|class="rShim"\ @width@|class="rShim"\ style="width: 9%%;"|' \
		 |	tidy -i -asxml -utf8 -w 0 - | sed \
		 -e 's|<table|<div\ id="sunday"\ class="tab-pane\ fade"><table|' \
		 -e 's|</table>|</table></div>|' > $@

in/Sunday-data.html: in/Sunday-tidy.html
	grep '\.tblGenFixed' $< | sed 's|td.s|td.sun-s|g' > in/Sunday.css
	sed -n '/\<table.*/,/<\/table>/ p' $< | sed -e 's|\([\ "]\)\(s[0-9]\+\)\([\ "]\)|\1sun-\2\3|g' > $@

in/Monday-tidy.html: in/Monday.html
	sed -e 's|<td\ class="rShim"\ style="width:0;"></td>||' \
		 -e 's|<td\ class="hd"><p\ style="height:16px;">.</p></td>||g' \
		 -e 's|td\ class="hd"><p\ style="height:16px;">.</p></td>||g' \
		 -e 's|class="rShim"\ style="width:120px;"|class="rShim"\ @width@|' \
		 $< |	sed 's|class="rShim"\ style="[^"]*"|class="rShim"\ style="width: 18%%;"|g' \
		 | sed 's|class="rShim"\ @width@|class="rShim"\ style="width: 10%%;"|' \
		 | tidy -i -asxml -utf8 -w 0 - | sed \
		 -e 's|<table|<div\ id="monday"\ class="tab-pane\ fade"><table|' \
		 -e 's|</table>|</table></div>|' > $@

in/Monday-data.html: in/Monday-tidy.html
	grep '\.tblGenFixed' $< | sed 's|td.s|td.mon-s|g' > in/Monday.css
	sed -n '/\<table.*/,/<\/table>/ p' $< | sed -e 's|\([\ "]\)\(s[0-9]\+\)\([\ "]\)|\1mon-\2\3|g' > $@

in/Tuesday-tidy.html: in/Tuesday.html
	sed -e 's|<td\ class="rShim"\ style="width:0;"></td>||' \
		 -e 's|<td\ class="hd"><p\ style="height:16px;">.</p></td>||g' \
		 -e 's|class="rShim"\ style="width:120px;"|class="rShim"\ @width@|' \
		 $< |	sed 's|class="rShim"\ style="[^"]*"|class="rShim"\ style="width: 18%%;"|g' \
		 | sed 's|class="rShim"\ @width@|class="rShim"\ style="width: 10%%;"|' \
		 |	tidy -i -asxml -utf8 -w 0 - | sed \
		 -e 's|<table|<div\ id="tuesday"\ class="tab-pane\ fade"><table|' \
		 -e 's|</table>|</table></div>|' > $@

in/Tuesday-data.html: in/Tuesday-tidy.html
	grep '\.tblGenFixed' $< | sed 's|td.s|td.tue-s|g' > in/Tuesday.css
	sed -n '/\<table.*/,/<\/table>/ p' $< | sed -e 's|\([\ "]\)\(s[0-9]\+\)\([\ "]\)|\1tue-\2\3|g' > $@

sed-rules: Makefile tail-template1.html track-template.html speaker-template.html tracks/* tracks.info speakers/* speakers.info static/*
	echo '' > tracks.html
	echo '' > speakers.html
	echo 's|cellpadding="0"||g' > $@
	echo 's|cellspacing="0"||g' >> $@
	echo 's|border="0"||g'      >> $@
	echo 's|id="tblMain"||g'    >> $@
	echo 's|>oSC<|><a href="http://conference.opensuse.org"><img style="padding: 5px;" src="static/suse_male.png" alt="openSUSE Conference 2012"/></a><|g'    >> $@
	echo 's|>FUTURE MEDIA Track<|><a href="http://bootstrapping-awesome.org/future-media"><img style="padding: 5px;" src="static/fm_male.png" alt="FUTURE MEDIA track"/></a><|g'    >> $@
	echo 's|>Gentoo<|><a href="http://miniconf.gentoo.org"><img style="padding: 5px;" src="static/gentoo_male.png" alt="Gentoo miniconf"/></a><|g'    >> $@
	echo 's|>LinuxDays<|><a href="http://www.linuxdays.cz"><img style="padding: 5px;" src="static/linuxdays_male.png" alt="LinuxDays"/></a><|g'    >> $@
	cat tail-template1.html > tail-generated.html
	# Create talks modals
	for i in tracks/*; do \
		code="`echo $$i | sed 's|tracks/||'`"; \
		echo " * Processing $$code ..." ;\
		data="`cat tracks.info | sed -e 's|;|:|g' -e 's|\t|;|g' | grep "^$$code;"`"; \
		description="`cat $$i`"; \
		del="" ;\
		authors="`   echo "$$data"   | cut -f  4 -d \;`"; \
		[ -z "$$authors" ] || del=":"    ; \
		lang="`      echo "$$data"   | cut -f  7 -d \;`"; \
		title="`     echo "$$data"   | cut -f  3 -d \; | sed 's|\ *$$||'`"; \
		type="`      echo "$$data"   | cut -f  2 -d \;`"; \
		room="`      echo "$$data"   | cut -f 13 -d \;`"; \
		day="`       echo "$$data"   | cut -f 11 -d \;`"; \
		time="`      echo "$$data"   | cut -f 12 -d \;`"; \
		skills="`    echo "$$data"   | cut -f 16 -d \;`"; \
		lang_verb="` echo "$$lang"   | sed -e 's|EN|English|' -e 's|CZ|Czech|'`" ; \
		skill_verb="`echo "$$skills" | sed -e 's|B|Beginners|' -e 's|I|Skilled users|' -e 's|H|Hardcore|'`" ; \
		[ -z "$$title" ] || echo "s|$$title|<img style='margin: 5px; float: left;' src='static/$$skills.png' alt='$$skill_verb'/><img style='margin: 5px; float: right;' src='static/$$lang.png' alt='$$lang_verb'/><em>$${authors}</em>$$del <a href='#$$code' data-toggle='modal'>$$title</a>|" >> $@ ; \
		. ./track-template.html.sh >> tracks.html ;\
		[ "%%title" ] || echo "$$code failed" ;\
		echo '    $$("#'"$$code"'").modal({ show: false });' >> tail-generated.html ; \
	done
	echo '' >  sed-rules1
	echo '' >  speakers-list.txt
	# Create speakers modals
	for i in speakers/*.info; do \
		code="`echo $$i | sed 's|speakers/\([^.]*\)\.info|\1|'`"; \
		echo " * Processing $$code ..." ;\
		description="`cat $$i`"; \
		data="`cat speakers.info | sed -e 's|;|:|g' -e 's|\t|;|g' | grep "^$$code;"`"; \
		name="`    echo "$$data" | cut -f  2 -d \;`"; \
		echo "$$name" >> speakers-list.txt ;\
		website="` echo "$$data" | cut -f  4 -d \;`"; \
		. ./speaker-template.html.sh >> speakers.html ;\
		echo "s|$$code|<a href='#$$code' data-toggle='modal'>$$name</a>|" | sed 's|\ |\\\ |g' >> sed-rules1 ; \
		echo '    $$("#'"$$code"'").modal({ show: false });' >> tail-generated.html ; \
	done
	sed -i -f sed-rules1 $@
	sed -i -f sed-rules1 tracks.html
	sed -i -e 's|\ |\\\ |g' -e 's|\&|\\\&amp;|g' -e 's|\/|\\\/|g' \
			 -e 's|\@|\\\@|g' -e '/^s||/ d' $@

tail.html: tail-generated.html tail-template2.html
	cat tracks.html speakers.html tail-generated.html tail-template2.html > $@
