#ifndef UNIQMLTK_GLOBAL_H
#define UNIQMLTK_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(UNIQMLTK_LIBRARY)
#define UNIQMLTK_EXPORT Q_DECL_EXPORT
#else
#define UNIQMLTK_EXPORT Q_DECL_IMPORT
#endif

#endif // UNIQMLTK_GLOBAL_H
