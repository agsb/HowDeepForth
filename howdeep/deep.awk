#!/usr/bin/awk
#       agsb@ 2026
#
#       emulate a Forth engine to verify dictionary of 
#       compiled word, counting:
#       former words, maximum deep return stack, 
#       number of primitives, number of compiled.
#
#       please, do not redefine words inside.

# define parameters
#
BEGIN {

  FS = " ";

  RS = "\n";

  SUBSEP = " ";

  colon = ":";
  
  semis = ";";

  dp = 0;

  np = 0;

}

#
# loop 
#
{
	
# clean line
gsub(/\r/,"", $0)
gsub(/\s+/," ", $0)
gsub(/^[ ]+/,"", $0)
gsub(/[ ]+$/,"", $0)
gsub(/[ ]+/," ", $0)

# valid line ? one forth word by line
if ( $1 != colon || $(NF) != semis ) next

# prepare 

word = $2 

# not allow redefine

if ( defined[word] != "" ) next

defined[word] = $0

# keep it

qtde[word] = NF - 3 
  
for (n = 3; n < NF; n++) {
    
        words[word, n - 3] = $(n)
  
        }

} 

END {

for (key in qtde) {
        
        # return stack index
        rp = 0
        
        # how deep 
        dp = 0

        # number of primitives
        np = 0

        # number of composed
        nc = 0

        print "\n@ " key " " qtde[key] 

        deep(key) 

        print "\n~ " key " " qtde[key] " " dp " " np " " nc    

        }

}

  
function deep( key,     n, m, yek) {

rp++

if (rp > dp) dp = rp

m = qtde[key]

for (n = 0; n < m; n++) {
    
        yek = words[key,n]

        if ( qtde[yek] > 0) { 
                nc++
                deep( yek ) 
                } 
        else {
                np++
                printf " " yek 
                }

        # escape next ?
        if (yek == "[']") {
                n++
                }

        }   

rp--

}

