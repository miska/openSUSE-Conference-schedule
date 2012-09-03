#!/bin/bash
echo "<div class='modal fade' id='$code'>
  <div class='modal-header'>
    <a class='close' data-dismiss='modal'>&times;</a>
    <h3><em>$authors</em>:<br/>$title</h3>
  </div>
  <div class='modal-body'>
    <img style='float: right;' src='static/$skills-big.png'/>
    <p><strong>Type:</strong> $type (`echo "$skills" | sed -e 's|B|Beginners|' -e 's|I|Skilled users|' -e 's|H|Hardcore|'`)</p>
    <p><strong>Language:</strong> `echo $lang | sed -e 's|EN|English|' -e 's|CZ|Czech|'` <img src='static/$lang.png'/></p>
    <p><strong>When:</strong> `echo "$time" | sed 's|-|\ -\ |'` `echo "$day" | sed -e 's|Sat|Saturday|' -e 's|Sun|Sunday|'`</p>
    <p><strong>Where:</strong> $room</p>
    <p><strong>Description:</strong></p>"
if [ -z "`echo "$description" | grep '<p>'`" ]; then
    echo "<p>$description</p>"
else
    echo "$description"
fi
echo "  </div>
  <div class='modal-footer'>
    <a href='#' class='btn' data-dismiss='modal'>Close</a>
  </div>
</div>"
