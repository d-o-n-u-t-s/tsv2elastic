### Description

This perl script will easy get contents from a MySQL database into Elasticsearch.

### Usage

easy import with mysql client.
```
$ mysql db -B -e "select * from tbl" | tsv2elastic.pl  --primary=[document id] --type=[elasticsearch type] --index=[elasticsearch inde\
x]
```
batch import sample.
```
#!/bin/sh
date=`date --date "1 days ago" +%Y%m%d`
prog='/usr/local/bin/tsv2elastic.pl'
mysql db -B -e "select *, from_unixtime(create_time,'%Y-%m-%dT%k:%i:%s+09:00') as '@timestamp' from tbl
where from_unixtime(create_time,'%Y%m%d') >= '${date}'" | ${prog} --primary=[id]id --type=[type] --index=[index]
```

### Contribution
[Donuts](https://github.com/d-o-n-u-t-s)

### License
```
The MIT License (MIT)

Copyright (c) 2015 Donuts Co.,Ltd.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

### Author
[star-board](https://github.com/star-board)

