require 'watir'

=begin
Program Purpose:
Strips text of big Donny T's tweets and searches for key terms in news

=end

browser = Watir::Browser.new

$url='https://twitter.com/hillaryclinton'
browser.goto($url)

#number of threads
puts "---Number of Tweets---"
threadnum= browser.ps(:class => 'tweet-text').size
puts threadnum
puts "---End---"
puts "\n"

#print out usr name
puts "--UserName--"
$handle=browser.element(class: 'ProfileHeaderCard-nameLink').text.strip

	#store name in file
	File.open("hc/handle.txt", "w") do |f|     
	f.write($handle)   
	end
	
puts browser.element(class: 'ProfileHeaderCard-nameLink').text.strip
puts"\n"

#print out text from p element
#puts browser.elements(class: 'tweet-text').text.strip
arr= browser.ps(class: 'tweet-text').map(&:text)


browser.goto('https://www.google.com/')

		z=0
while z < 12 do
browser.goto('https://www.google.com/')

#send text to google
$altsearch= arr[z].split("the")
#puts "ALTSEARCH >> "+$altsearch[1]

$mainsearch = arr[z]

#this is slipt by the word <the>
#searchtext=$altsearch[1]

#this is not split
searchtext=arr[z].to_s
browser.input(name: 'q').send_keys(searchtext)

browser.button(:id=> '_fZl').click

#print class text
puts browser.element(class: 'r').text

#print out links
links = browser.h3s(class: 'r').map(&:link)
#strings are stored in hrefs
page_hrefs = links.map(&:href)

#print out links
names= browser.h3s(class: 'r').map(&:text)
puts "---Names---"



#store name in file
filename="hc/dt_tweet"+z.to_s+".txt"
	File.open(filename, "w") do |f|     
	
	
	#write strings as html
	f.write("<center>")
	
	#printout of tweet
	#puts "--TWEET--"
	#puts arr[z].to_s
	#puts "\n"
	f.write("<h3>"+arr[z]+"</h3>")
	f.write("<hr>")
	zz=0
	while zz < 12 do
	f.write("<p class='darktext'><a href='"+page_hrefs[zz].to_s+"'>"+names[zz].to_s+"</a>"+"</p>")
		zz+=1
	end

	f.write("</center>")
	f.write("<br>")
	
	end
	
	
	z+=1
end






=begin
puts "--Links--"
links = browser.ps(class: 'tweet-text').map(&:link)
#strings are stored in hrefs
hrefs = links.map(&:href)
links.each { |link| puts "#{link.data_href || link.href}" }
puts "\n"

=begin

#strip text of <div class=thread>
names= browser.divs(class: 'thread').map(&:text)


#file save for thread text
zz=0
aFile = File.new("test_in.txt", "r+")
if aFile
while zz < threadnum do
   aFile.syswrite("--Thread--")
	aFile.syswrite("\n")
   aFile.syswrite(names[zz])
   aFile.syswrite("\n")
zz+=1
end
else
   puts "Unable to open file!"
end
aFile.close
=end