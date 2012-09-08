#!/bin/bash
echo "<div class='modal fade' id='$code'>
  <div class='modal-header'>
    <a class='close' data-dismiss='modal'>&times;</a>
    <h3>$title</h3>
  </div>
  <div class='modal-body'>
    <img style='float: right;' src='static/$skills-big.png' alt='$skill_verb'/>
    <p><strong>Speaker(s):</strong> <em>$authors</em></p>
    <p><strong>Type:</strong> $type ($skill_verb)</p>
    <p><strong>Language:</strong> $lang_verb <img src='static/$lang.png' alt='$lang_verb'/></p>
    <p><strong>When:</strong> `echo "$time" | sed 's|-|\ -\ |'` `echo "$day" | sed -e 's|Sat|Saturday|' -e 's|Sun|Sunday|' -e 's|Mon|Monday|' -e 's|Tue|Tuesday|' `</p>
    <p><strong>Where:</strong> $room</p>
    <p><strong>Description:</strong></p>"
if [ -z "`echo "$description" | head -n 1 | grep '^<'`" ]; then
    echo "<p>$description</p>"
else
    echo "$description"
fi
echo "  </div>
  <div class='modal-footer'>
    <a href='#' class='btn' data-dismiss='modal'>Close</a>
  </div>
</div>"
