from tld import get_tld
import argparse

parser = argparse.ArgumentParser(usage="python3 build-proxy.py -f file", add_help=False)
parser.add_argument("-f", "--file", dest="file", help="Select a target list file (e.g. list.txt )")
args = parser.parse_args()

if args.file:
    for line in open(args.file):
        line = line.strip("\n")
        try:
            result = get_tld(line, as_object=True, fix_protocol=True)
            root_domain = result.fld
            with open("./dist/proxy1.txt", "a+", encoding="utf-8") as file1:
                file1.write("." + root_domain + "\n")
            with open("./dist/proxy2.txt", "a+", encoding="utf-8") as file2:
                file2.write("  - '+." + root_domain + "'\n")
        except:
            pass

if args.file is None:
    exit(0)
