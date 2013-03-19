# -*- coding: iso-8859-15 -*-
"""Simple FunkLoad test

$Id$
"""
import unittest
from random import random
from funkload.FunkLoadTestCase import FunkLoadTestCase

PAGES = (('Homepage', ''),
         ('path1', 'contacts'),
         ('path2', 'media'),
         )

class Site(FunkLoadTestCase):
    """This test use a configuration file Site.conf."""

    def setUp(self):
        """Setting up test."""
        self.server_url = self.conf_get('main', 'url')

    def test_app(self):
        ''' site path
        '''
        server_url = self.server_url

        for title, page in PAGES:
            url = "/".join((server_url, page))
            self.get(url, description='Get %s' % title)


if __name__ in ('main', '__main__'):
    unittest.main()
