#!/bin/bash
echo "<div class='modal fade' id='$code'>
  <div class='modal-header'>
    <a class='close' data-dismiss='modal'>&times;</a>
    <h3><em>$name</em></h3>"
[ -z "$website" ] || for i in $website; do
echo "    <p><a href='$i' target='_blank'>$i</a></p>"
done
echo "  </div>
  <div class='modal-body'>"
[ \! -f "static/$code.jpg" ] || echo "    <img style='float: right;' src='static/$code.jpg' alt='$name'/>"
echo "    <p><strong>About the speaker:</strong></p>"
if [ -z "`echo "$description" | grep '<p>'`" ]; then
    echo "<p>$description</p>"
else
    echo "$description"
fi
echo "    <p><strong>Speaker's sessions:</strong></p>"
echo "    <p><ul>"
grep "$code" tracks.info | sed -e 's|;|:|g' -e 's|\t|;|g' | while read data; do
		authors="`  echo "$data" | cut -f  4 -d \;`"
		lang="`     echo "$data" | cut -f  7 -d \;`"
		title="`    echo "$data" | cut -f  3 -d \; | sed 's|\ *$||'`"
		tpe="`      echo "$data" | cut -f  2 -d \;`"
		room="`     echo "$data" | cut -f 13 -d \;`"
		day="`      echo "$data" | cut -f 11 -d \;`"
		tme="`      echo "$data" | cut -f 12 -d \;`"
      echo "<li><p><strong>$title</strong> (<em>$tpe</em>)</p><p style='text-align: right;'><small><em>`echo "$day" | sed -e 's|Sat|Saturday|' -e 's|Sun|Sunday|'`</em> at `echo "$tme" | sed 's|-|\ -\ |'` room <strong>$room</strong></small></p></li>"
done
echo "    </ul></p>"
echo "  </div>
  <div class='modal-footer'>
    <a href='#' class='btn' data-dismiss='modal'>Close</a>
  </div>
</div>"
