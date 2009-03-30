#!/bin/bash

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
# 2008 Â© La France du Nord au Sud - Laurent Ollagnier <laurent.ollagnier@dunordausud.fr>
# 2007 © Laurent "yam" OLLAGNIER <laurent@quarantedeux.net>

################################################################################
# CONFIGURATION                                                                #
################################################################################
LOGFILE='/var/log/apache2/access.log.1' # Absolute path 
#LOGFILE='/home/yam/ccess.log'
OUTPUT='/var/www/stats/'
SPLF_BIN='/usr/sbin/split-logfile'
WEBALIZER_BIN='/usr/bin/webalizer'
TMPDIR='/var/log/tmp'
################################################################################
# Begin
#
tempdir=$(mktemp -d -p ${TMPDIR})
pushd ${tempdir} > /dev/null
$(${SPLF_BIN} < ${LOGFILE}) # on split
for logfile in *.log
do
    host=$(echo ${logfile}|sed s/\.log$//)

    if ! [ -d $OUTPUT/${host} ]
    then
        mkdir $OUTPUT/${host}
    fi
    
    webalizer -Q -p -n ${host} -o ${OUTPUT}/${host} ${logfile} > /dev/null
done
popd > /dev/null
rm -rf ${tempdir}
