
# MOSS Downloader
Download the plagiarism check results from moss's website, for offline viewing, as moss invalidates the result url after 14 days

## Usage:  `moss-downloader options`

### Options:

```
		-u, --url link for the moss results, required
		-q, --quiet do not display any wget logs, default no
		-o, --output-dir output directory to store the downloaded webpages from moss website, default moss_results
		-n, --number number of moss matches to download, default top 10
		-h, --help display this help and exit
```

##  Examples:

    
    ```
      	./moss-downloader.sh -u <moss-url> -n "5" -o <output directory name>
    ```
    
 
    
-   Downloads the top 5 moss plagiarism results from the given url
    

    

## Installation


##  Requirements

-   wget
