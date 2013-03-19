LOG_HOME := var/funkload/log
REPORT_HOME := var/funkload/data

ifdef URL
    FLOPS = -u $(URL) $(EXT)
else
    FLOPS = $(EXT)
endif

ifdef REPORT_HOME
    REPORT = $(REPORT_HOME)
else
    REPORT = report
endif

all: test

test: start test-app

bench: start bench-app

start:
	-mkdir -p $(REPORT)  $(LOG_HOME)

test-app:
	fl-run-test -d --debug-level=3 --simple-fetch site_test.py Site.test_app $(FLOPS)

bench-app:
	-fl-run-bench --simple-fetch site_test.py Site.test_app -c 1:5:10:15:20:30:40:50 -D 45 -m 0.1 -M .5 -s 1 $(FLOPS)
	-fl-build-report $(LOG_HOME)/site-bench.xml --html -o $(REPORT)

clean:
	-find . "(" -name "*~" -or  -name ".#*" -or  -name "*.pyc" ")" -print0 | xargs -0 rm -f