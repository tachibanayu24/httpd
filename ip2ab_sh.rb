while line=gets do
        line.chomp!
        print "ab -n 1000 http://", line, "/ > _result_ab_", line, ".txt &\n"
end
print "echo Fin!"
