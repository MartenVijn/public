
# install markdown meuk
# npm install markdown-pdf -g
# npm install markdown -g

for file in `ls *.md | cut -d'.' -f1`
do	
#	md2html -f $file.md 
	md2html $file.md > ${file}.html
    markdown-pdf $file.md
	svn add *
	svn propset svn:mime-type application/pdf $file.pdf
        svn propset svn:mime-type text/html $file.html
done

svn ci -m "update $1"
