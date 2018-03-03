# Copyright (C) 2018 SacredOS ROM
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#Sacred Versioning
SACRED_VERSION = v1.1

#ifndef SACRED_BUILD_TYPE
    SACRED_BUILD_TYPE := BETA
#endif

SACRED_MOD_VERSION := SacredOS-$(SACRED_VERSION)-$(shell date -u +%Y%m%d-%H%M)-$(SACRED_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.sacred.version=$(SACRED_VERSION) \
  ro.sacred.releasetype=$(SACRED_BUILD_TYPE) \
  ro.modversion=$(SACRED_MOD_VERSION)

SACRED_DISPLAY_VERSION := SacredOS-$(SACRED_VERSION)-$(SACRED_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.sacred.display.version=$(SACRED_DISPLAY_VERSION)
