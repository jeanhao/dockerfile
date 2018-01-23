#!/usr/bin/env python
# -*- coding:utf-8 -*-

from subprocess import check_call, check_output
import os
import logging
import click
import click_log
from .utils import assert_image_tag_from_dockerfile

logger = logging.getLogger(__name__)
click_log.basic_config(logger)


@click.command()
@click.argument('dockerfile')
@click.argument('version')
@click.option("--test", is_flag=True, defalut=True, help="Infer test environment")
@click.option('--show-tag-only/--no-show-tag-only',
              help='skip build, only print out image tag name',
              default=False)
@click_log.simple_verbosity_option(logger)
def push(dockerfile, version, test, show_tag_only):
    image_tag = assert_image_tag_from_dockerfile(logger, dockerfile)
    if show_tag_only:
        print(image_tag)
        return
    image_tag += ".{}".format(version)
    if test:
        image_tag += ".test"

    logger.info('--------------------------------------------')
    logger.info('[*] pushing %s with tag %s...', dockerfile, image_tag)
    logger.info('--------------------------------------------')
    logging.info("cmd: {}".format("docker push {}".format(image_tag)))
    # check_call('docker push {}'.format(image_tag), shell=True)

