/* Copyright (c) 2007-2012 Massachusetts Institute of Technology
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 */

#include "nlopt-util.h"

#if TIME_WITH_SYS_TIME
#ifdef __WXMSW__
	#include "sys/time.h"
#else
	# include <sys/time.h>
#endif // __WXMSW__
# include <time.h>
#else
# if HAVE_SYS_TIME_H
#  include <sys/time.h>
# else
#  include <time.h>
# endif
#endif

#if defined(_WIN32) || defined(__WIN32__)
#  include <windows.h>    
#endif

/* return time in seconds since some arbitrary point in the past */
double nlopt_seconds(void)
{
     static THREADLOCAL int start_inited = 0; /* whether start time has been initialized */
     return (double)time(NULL);
}

/* number based on time for use as random seed */
unsigned long nlopt_time_seed(void)
{
     return (unsigned long)time(NULL);
}
