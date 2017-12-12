from __future__ import print_function


import hashlib
import sys
import requests
import os
import glob
from shell import ex

JOB_LIST_DIR = 'ci/jobs'

def find_all_dockerfiles():
    dockerfiles = []
    parent_path = "dl"
    for root, dirs, files in os.walk(parent_path):
        for filename in files:
            if 'Dockerfile' in filename: 
                dockerfiles.append(os.sep.join((root, filename)))  
    return dockerfiles

def find_one_dockerfile():
    return ["dl/caffe/1.0/Dockerfile-py2"]

def test(dockerfiles):
    for dockerfile_path in dockerfiles:
        # Using dockerfile_path for filename would be a pain in the ass to work
        # with because it contains os.sep. Here, we run it through a hash function
        # to simplify it while still maintain the uniqueness.
        job_id = hashlib.sha224(dockerfile_path).hexdigest()
        print('Creating jobs file %s for %s...' % (job_id, dockerfile_path))
        with open(os.path.join(JOB_LIST_DIR, job_id + '.job'), 'w') as f:
            f.write(dockerfile_path)

    rebuild_glob_pattern = os.environ.get('FORCE_REBUILD_GLOB')
    if rebuild_glob_pattern:
        print(('[*] Found $FORCE_REBUILD_GLOB ENV VAR: %r, '
            'search for list of files to rebuild...') % (rebuild_glob_pattern))
        for matched_file in glob.glob(rebuild_glob_pattern):
            if 'Dockerfile' in matched_file:
                job_id = hashlib.sha224(matched_file).hexdigest()
                print('Creating jobs file %s for %s...' % (job_id, matched_file))
                with open(os.path.join(JOB_LIST_DIR, job_id + '.job'), 'w') as f:
                    f.write(matched_file)
def main():
    if not os.path.isdir(JOB_LIST_DIR):
        os.mkdir(JOB_LIST_DIR)
    
    test(find_one_dockerfile())
    # test(find_all_dockerfiles())
if __name__ == "__main__":
    main()