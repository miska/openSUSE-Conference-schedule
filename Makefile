all: sed-rules tail.html tail.html schedule-head1.html schedule-head2.html in/Saturday-data.html in/Sunday-data.html in/Monday-data.html in/Tuesday-data.html
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

sed-rules: Makefile tail-template.html track-template.html tracks/* tracks.info
	echo '' > tracks.html
	rm -f $@
	cat tail-template.html > tail-generated.html
	for i in tracks/*; do \
		code="`echo $$i | sed 's|tracks/||'`"; \
		echo " * Processing $$code ..." ;\
		data="`cat tracks.info | sed -e 's|;|:|g' -e 's|\t|;|g' | grep "^$$code;"`"; \
		description="`cat $$i`"; \
		authors="`  echo "$$data" | cut -f  4 -d \;`"; \
		lang="`     echo "$$data" | cut -f  7 -d \;`"; \
		title="`    echo "$$data" | cut -f  3 -d \;`"; \
		type="`     echo "$$data" | cut -f  2 -d \;`"; \
		room="`     echo "$$data" | cut -f 13 -d \;`"; \
		day="`      echo "$$data" | cut -f 11 -d \;`"; \
		time="`     echo "$$data" | cut -f 12 -d \;`"; \
		skills="`   echo "$$data" | cut -f 16 -d \;`"; \
		[ -z "$$title" ] || echo "s|$$title|<img style='float: left;' src='static/$$skills.png'/><em>$${authors}:</em> <a href='#$$code' data-toggle='modal'>$$title</a><img style='float: right;' src='static/$$lang.png'/>|" >> $@ ; \
		. ./track-template.html.sh >> tracks.html ;\
		[ "%%title" ] || echo "$$code failed" ;\
		echo '    $$("#'"$$code"'").modal({ show: false });' >> tail-generated.html ; \
	done
	sed -i -e 's|\ |\\\ |g' -e 's|\&|\\\&amp;|g' -e 's|\/|\\\/|g' \
			 -e 's|\@|\\\@|g' -e '/^s||/ d' $@

tail.html: tail-template.html tail-generated.html
	echo -e '  });\n  </script>\n</body>\n</html>' | cat tracks.html tail-generated.html - > $@
