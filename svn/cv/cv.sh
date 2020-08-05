
# install markdown meuk
# npm install markdown-pdf -g
# npm install markdown -g

for file in cv_2020
do	
#	md2html -f $file.md 
	md2html $file.md > ${file}.html
        markdown-pdf $file.md
done

