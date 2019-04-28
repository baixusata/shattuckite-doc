if [ ! -d Team105 ]
then
     git clone --depth=5 git@github.com:sebuaa2019/Team105.git;
fi

cd build
path=$1
head1="shattuckite*SDP*.pdf"
head2="shattuckite*PRD*.pdf"
head3="shattuckite*SDD*.pdf"
files=$(ls $path)
for filename in $files
do 
 if [ ${filename} = ${head1} ]
 then
 	sdp=${filename}
	sdp_hash=${filename##*-}
 elif [ ${filename} = ${head2} ]
 then
	prd=${filename}
	prd_hash=${filename##*-}
 elif [ ${filename} = ${head3} ]
 then
	sdd=${filename}
	sdd_hash=${filename##*-}
 fi
done

cd ../Team105
path=$1
head1="设计文档*"
head2="项目计划书*"
head3="需求文档*"
files=$(ls $path)
for filename in $files
do
 if [ ${filename} = ${head1} ]
 then
	sdd_old_hash=${filename##*-}
	if [ ${sdd_hash} = ${sdd_old_hash} ]
	then
		echo ${sdd}
		echo ${filename}
		echo sdd_compare
	else
		rm ./${filename}
		cp ../build/${sdd} ./"设计文档-"${sdd#*-}
	fi
 elif [ ${filename} = ${head2} ]
 then
	sdp_old_hash=${filename##*-}
	if [ ${sdp_hash} = ${sdp_old_hash} ]
	then
		echo ${sdp}
		echo ${filename}
		echo sdp_compare
	else
		rm ./${filename}
		cp ../build/${sdp} ./"项目计划书-"${sdp#*-}
	fi
 elif [ ${filename} = ${head3} ]
 then
	prd_old_hash=${filename##*-}
	if [ ${prd_hash} = ${prd_old_hash} ]
	then
		echo ${prd}
		echo ${filename}
		echo prd_compare
	else
		rm ./${filename}
		cp ../build/${prd} ./"需求文档-"${prd#*-}
	fi
 fi
done

git add -A
echo auto CI build >/tmp/message
git commit -F /tmp/message
git push origin master
