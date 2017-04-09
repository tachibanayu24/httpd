Version = 1.08
#
# Targets に，アクセス先 URL を設定する．
#	方法 1
#		例:[ 'localhost', 3000, '/people' ] なら，
#		ホスト localhost，port 3000，ファイル /people にアクセス．
#		つまり http://localhost:3000/people にアクセス．
#	方法 2
#		NumOfServers を指定する．
#		結果として ['localhost',3000+i,'/people'] が複数作成される．
#	方法 3
#		URL リストが書かれたファイルを読み込ませる．
#		結果として ['localhost',3000+i,'/people'] が複数作成される．
# Repeat に 繰り返し回数を指定する．
# PrintHTML で，「取得 HTML を表示するか否か」を設定する．
#

require 'net/http'

Repeat = 10000
PrintHTML = false
UseProxy = false
FileSkew = nil
AvgSleep_Sec = nil

########
#NumOfServers = 8
#NumOfFiles = 5
#ProxyHost = 'cache.cc.kogakuin.ac.jp'
#ProxyPort = 8080
#if ARGV.length < 3 then
#	print "ruby web_random_access_bench.rb ServerName AvgSleep[sec] FileSkew(avg)\n"
#	exit
#end
#ServerName = ARGV[0]
#AvgSleep_Sec = ARGV[1].to_f
#FileSkew = ARGV[2].to_f

########
#targets = Array.new
#NumOfServers.times do | i |
#	targets.push( ['localhost',3000+i,'/people'] )
#end
#Targets = targets

########
#targets = Array.new
#NumOfFiles.times do | i |
#	filename = sprintf("/%04d.html", i)
#	targets.push( [ServerName, 80, filename] )
#end
#Targets = targets

########
#targets = Array.new
#[
#	"192.168.11.4",
#	"192.168.11.5",
#	"192.168.11.6",
#	"192.168.11.7",
#	"192.168.11.8",
#	"192.168.11.9",
#	"192.168.11.10",
#	"192.168.11.11",
#	"192.168.11.12",
#	"192.168.11.13"
#].each do | srv |
#	NumOfFiles.times do | j |
#		filename = sprintf("/%04d.html", j)
#		targets.push( [srv, 80, filename] )
#	end
#end
#Targets = targets

########
#Targets = [
#	['192.168.122.74',80,'/people'],
#	['192.168.122.102',80,'/people'],
#	['192.168.122.135',80,'/people'],
#	['192.168.122.233',80,'/people'],
#	['192.168.122.51',80,'/people'],
#	['192.168.122.177',80,'/people'],
#	['192.168.122.113',80,'/people'],
#	['192.168.122.201',80,'/people'],
#	['192.168.122.7',80,'/people'],
#	['192.168.122.72',80,'/people']
#]

########
Targets = []
if 0 < ARGV.length then
	begin
		open( ARGV[0] ) do | fi |
			while line = fi.gets do
				ipaddr = line.chomp
				#print ipaddr
				Targets.push( [ipaddr, 80, '/'] )
			end
		end
	rescue
	end
else
	print "ruby web_random_access_bench.rb URLfile\n"
	exit
end


def exp_dist(avg)
	r = rand
	e = -avg*Math.log(r)
end


time_s = Time.now - 0
sum_sleep = 0
Repeat.times do | i |
	print i, ' / '
	if FileSkew then
		r = exp_dist(FileSkew)
	#	print r, ' '
		r = r.to_i % Targets.length
	else
		r = rand % Targets.length
	end
	print r, ' '
	print Targets[r].join(","), " "

	Net::HTTP.version_1_2
	if UseProxy then
		Net::HTTP.Proxy(ProxyHost,ProxyPort)
	else
		Net::HTTP
	end .start(Targets[r][0], Targets[r][1]) do |http|
		time_pre = Time.now
		response = http.get(Targets[r][2])
		time_post = Time.now
		if PrintHTML then
			puts response.body
		end
		print "Resp[sec]= ", (time_post - time_pre), " "
	end

	if AvgSleep_Sec then
		a_sleep = exp_dist(AvgSleep_Sec*1000)/1000.0
		sum_sleep += a_sleep
		b_sleep = time_s + sum_sleep - Time.now
		if 0 < b_sleep then
	#		print a_sleep, ' -> '
			print'sleep( ', b_sleep, " ) "
			sleep( b_sleep )
	#		print "done\n"
		else
	#		print "@@ @@ no sleep @@ @@\n"
		end
	end
	print "\n"
end
time_e = Time.now
print Repeat, " [times], ",(time_e - time_s), " [sec]\n"
