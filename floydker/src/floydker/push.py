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
@click.option("--test", is_flag=True, default=False, help="Infer test environment")
@click.option('--show-tag-only/--no-show-tag-only',
              help='skip build, only print out image tag name',
              default=False)
@click_log.simple_verbosity_option(logger)
def push(dockerfile, version, test, show_tag_only):
    image_tag = assert_image_tag_from_dockerfile(logger, dockerfile)
    if show_tag_only:
        print(image_tag)
        return
    target_image_tag = "{}.{}".format(image_tag, version)
    if test:
        target_image_tag += ".test"
    logger.info('--------------------------------------------')
    logger.info('[*] taging image %s with %s to replace tag %s...', dockerfile, target_image_tag, image_tag)
    logger.info('--------------------------------------------')
    check_call("docker tag {} {}".format(image_tag, target_image_tag), shell=True)

    logger.info('--------------------------------------------')
    logger.info('[*] pushing %s with tag %s...', dockerfile, image_tag)
    logger.info('--------------------------------------------')
    cmd = "docker push {}".format(image_tag)
    logging.info("cmd: {}".format(cmd))
    check_call(cmd, shell=True)
