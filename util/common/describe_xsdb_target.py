
import argparse
import pyxsdb


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--url', default='', help='target URI of xsdb server. If omitted, connect to localhost')
    args = parser.parse_args()

    xsdb = pyxsdb.PyXsdb()
    xsdb.connect(args.url)

    print(xsdb.describe_target())

if __name__ == '__main__':
    main()
