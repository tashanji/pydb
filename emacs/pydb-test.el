(load-file "./elk-test.el")
(load-file "./pydb.el")

(defun regexp-test (location-str file-str)
  "Test to see that location-str matches gud-pydb-marker-regexp"
  (assert-equal 0 (string-match gud-pydb-marker-regexp location-str))
  (assert-equal file-str
		(substring location-str
			   (match-beginning gud-pydb-marker-regexp-file-group) 
			   (match-end gud-pydb-marker-regexp-file-group)))
)
(deftest "pydb-marker-regexp-test"

  (regexp-test 
   "(e:\\sources\\capfilterscanner\\capanalyzer.py:3):  <module>"
   "e:\\sources\\capfilterscanner\\capanalyzer.py"
   )
  (regexp-test 
   "(/tmp/gcd.py:29):  gcd"
   "/tmp/gcd.py"
   )
)

(build-suite "pydb-suite" "pydb-marker-regexp-test")
(run-elk-test "pydb-marker-regexp-test"
              "test regular expression used in tracking lines")
