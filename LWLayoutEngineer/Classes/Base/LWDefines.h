//
//  LWDefines.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#ifdef __GNUC__
# define LWLAYOUT_GNUC(major, minor) \
(__GNUC__ > (major) || (__GNUC__ == (major) && __GNUC_MINOR__ >= (minor)))
#else
# define LWLAYOUT_GNUC(major, minor) 0
#endif

#ifndef LWLAYOUT_INLINE
# if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
#  define LWLAYOUT_INLINE static inline
# elif defined (__MWERKS__) || defined (__cplusplus)
#  define LWLAYOUT_INLINE static inline
# elif ASDISPLAYNODE_GNUC (3, 0)
#  define LWLAYOUT_INLINE static __inline__ __attribute__ ((always_inline))
# else
#  define LWLAYOUT_INLINE static
# endif
#endif

#ifndef LW_UNAVAILABLE
#if __has_attribute(unavailable)
#define LW_UNAVAILABLE(message) __attribute__((unavailable(message)))
#else
#define LW_UNAVAILABLE(message)
#endif
#endif

#ifndef LW_WARN_UNUSED_RESULT
#if __has_attribute(warn_unused_result)
#define LW_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
#define LW_WARN_UNUSED_RESULT
#endif
#endif
