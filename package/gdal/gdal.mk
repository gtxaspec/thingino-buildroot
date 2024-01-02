################################################################################
#
# gdal
#
################################################################################

GDAL_VERSION = 3.8.2
GDAL_SITE = https://download.osgeo.org/gdal/$(GDAL_VERSION)
GDAL_SOURCE = gdal-$(GDAL_VERSION).tar.xz
GDAL_LICENSE = Apache-2.0, ISC, MIT, many others
GDAL_LICENSE_FILES = LICENSE.TXT
GDAL_CPE_ID_VENDOR = osgeo
GDAL_INSTALL_STAGING = YES
GDAL_CONFIG_SCRIPTS = gdal-config
GDAL_SUPPORTS_IN_SOURCE_BUILD = NO

# gdal at its core only needs host-pkgconf, libgeotiff, proj and tiff
# but since by default mrf driver support is enabled, it also needs
# jpeg, libpng and zlib. By default there are also many other drivers
# enabled but it seems, in contrast to mrf driver support, that they
# can be implicitly disabled, by configuring gdal without their
# respectively needed dependencies.
GDAL_DEPENDENCIES = \
	giflib \
	host-pkgconf \
	jpeg \
	json-c \
	libgeotiff \
	libpng \
	proj \
	qhull \
	tiff \
	zlib

# Yes, even though they have -DDGDAL_USE options, a few libraries are
# mandatory. If we don't provide them, bundled versions are used.
GDAL_CONF_OPTS = \
	-DGDAL_USE_GEOTIFF=ON \
	-DGDAL_USE_GIF=ON \
	-DGDAL_USE_JPEG=ON \
	-DGDAL_USE_JSONC=ON \
	-DGDAL_USE_ZLIB=ON \
	-DGDAL_USE_PNG=ON \
	-DGDAL_USE_QHULL=ON \
	-DGDAL_USE_ARMADILLO=OFF \
	-DGDAL_USE_BLOSC=OFF \
	-DGDAL_USE_BRUNSLI=OFF \
	-DGDAL_USE_CFITSIO=OFF \
	-DGDAL_USE_OPENSSL=OFF \
	-DGDAL_USE_CRYPTOPP=OFF \
	-DGDAL_USE_CRNLIB=OFF \
	-DGDAL_USE_CURL=OFF \
	-DGDAL_USE_ECW=OFF \
	-DGDAL_USE_FILEGDB=OFF \
	-DGDAL_USE_FREEXL=OFF \
	-DGDAL_USE_GEOS=OFF \
	-DGDAL_USE_LIBKML=OFF \
	-DGDAL_USE_LZ4=OFF \
	-DGDAL_USE_GTA=OFF \
	-DGDAL_USE_HDF4=OFF \
	-DGDAL_USE_HDF5=OFF \
	-DGDAL_USE_HDFS=OFF \
	-DGDAL_USE_HEIF=OFF \
	-DGDAL_USE_IDB=OFF \
	-DGDAL_USE_LURATECH=OFF \
	-DGDAL_USE_JPEG12_INTERNAL=OFF \
	-DGDAL_USE_JXL=OFF \
	-DGDAL_USE_KDU=OFF \
	-DGDAL_USE_KEA=OFF \
	-DGDAL_USE_LERC=OFF \
	-DGDAL_USE_LIBLZMA=OFF \
	-DGDAL_USE_DEFLATE=OFF \
	-DGDAL_USE_MONGOCXX=OFF \
	-DGDAL_USE_MRSID=OFF \
	-DGDAL_USE_PUBLICDECOMPWT=OFF \
	-DGDAL_USE_MYSQL=OFF \
	-DGDAL_USE_NETCDF=OFF \
	-DGDAL_USE_ORACLE=OFF \
	-DGDAL_USE_ODBC=OFF \
	-DGDAL_USE_OGDI=OFF \
	-DGDAL_USE_OPENCL=OFF \
	-DGDAL_USE_OPENEXR=OFF \
	-DGDAL_USE_OPENJPEG=OFF \
	-DGDAL_USE_PCRE=OFF \
	-DGDAL_USE_PCRE2=OFF \
	-DGDAL_USE_PDFIUM=OFF \
	-DGDAL_USE_PODOFO=OFF \
	-DGDAL_USE_POPPLER=OFF \
	-DGDAL_USE_RASTERLITE2=OFF \
	-DGDAL_USE_RDB=OFF \
	-DGDAL_USE_SFCGAL=OFF \
	-DGDAL_USE_FYBA=OFF \
	-DGDAL_USE_SPATIALITE=OFF \
	-DGDAL_USE_SQLITE3=OFF \
	-DGDAL_USE_TEIGHA=OFF \
	-DGDAL_USE_TILEDB=OFF \
	-DGDAL_USE_WEBP=OFF \
	-DGDAL_USE_XERCESC=OFF \
	-DGDAL_USE_ZSTD=OFF \
	-DGDAL_ENABLE_DRIVER_PCIDSK=OFF \
	-DGDAL_ENABLE_DRIVER_PCRASTER=OFF \
	-DGDAL_ENABLE_DRIVER_NULL=OFF \
	-DGDAL_ENABLE_MACOSX_FRAMEWORK=OFF \
	-DENABLE_GNM=OFF \
	-DENABLE_PAM=OFF \
	-DBUILD_JAVA_BINDINGS=OFF \
	-DBUILD_PYTHON_BINDINGS=OFF

ifeq ($(BR2_PACKAGE_EXPAT),y)
GDAL_DEPENDENCIES += expat
GDAL_CONF_OPTS += -DGDAL_USE_EXPAT=ON
else
GDAL_CONF_OPTS += -DGDAL_USE_EXPAT=OFF
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
GDAL_DEPENDENCIES += libxml2
GDAL_CONF_OPTS += -DGDAL_USE_LIBXML2=ON
else
GDAL_CONF_OPTS += -DGDAL_USE_LIBXML2=OFF
endif

ifeq ($(BR2_PACKAGE_POSTGRESQL),y)
GDAL_DEPENDENCIES += postgresql
GDAL_CONF_OPTS += -DGDAL_USE_POSTGRESQL=ON
else
GDAL_CONF_OPTS += -DGDAL_USE_POSTGRESQL=OFF
endif

$(eval $(cmake-package))
