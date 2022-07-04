{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_algo (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/r/.cabal/bin"
libdir     = "/Users/r/.cabal/lib/x86_64-osx-ghc-8.10.7/algo-0.1.0.0-LGNUunTa4nQATWpiWCL3ow-algo-exe"
dynlibdir  = "/Users/r/.cabal/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/r/.cabal/share/x86_64-osx-ghc-8.10.7/algo-0.1.0.0"
libexecdir = "/Users/r/.cabal/libexec/x86_64-osx-ghc-8.10.7/algo-0.1.0.0"
sysconfdir = "/Users/r/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "algo_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "algo_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "algo_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "algo_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "algo_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "algo_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
