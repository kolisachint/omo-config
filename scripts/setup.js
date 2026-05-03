#!/usr/bin/env node
/**
 * OMO Setup Script
 * One-command installer for oh-my-openagent config
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const CONFIG_DIR = path.join(os.homedir(), '.config', 'opencode');
const TARGET_FILE = path.join(CONFIG_DIR, 'oh-my-openagent.json');

const REPO_ROOT = path.join(__dirname, '..');
const PROFILES_DIR = path.join(REPO_ROOT, 'profiles');

function ensureDir(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
    console.log(`📁 Created: ${dir}`);
  }
}

function copyFile(src, dest) {
  fs.copyFileSync(src, dest);
}

function backupIfExists(file) {
  if (fs.existsSync(file)) {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const backup = `${file}.backup-${timestamp}`;
    fs.copyFileSync(file, backup);
    console.log(`💾 Backup: ${path.basename(backup)}`);
    return backup;
  }
  return null;
}

function installProfile(name = 'codex-daily') {
  const profileFile = path.join(PROFILES_DIR, `${name}.json`);
  if (!fs.existsSync(profileFile)) {
    console.error(`❌ Profile not found: ${profileFile}`);
    process.exit(1);
  }
  backupIfExists(TARGET_FILE);
  copyFile(profileFile, TARGET_FILE);
  console.log(`✅ Installed profile: ${name}`);
}

function installBin() {
  const binSrc = path.join(REPO_ROOT, 'bin', 'omo');
  if (!fs.existsSync(binSrc)) {
    console.log('⚠️  omo binary not found');
    return;
  }

  const possiblePaths = [
    path.join(os.homedir(), '.local', 'bin'),
    path.join(os.homedir(), 'bin'),
    '/usr/local/bin'
  ];

  const pathEnv = process.env.PATH || '';
  if (pathEnv.split(path.delimiter).some(p => binSrc.startsWith(p) || p === path.dirname(binSrc))) {
    console.log(`✅ omo is already in PATH via: ${path.dirname(binSrc)}`);
    return;
  }

  for (const binDir of possiblePaths) {
    try {
      ensureDir(binDir);
      const linkPath = path.join(binDir, 'omo');
      if (fs.existsSync(linkPath)) {
        fs.unlinkSync(linkPath);
      }
      fs.symlinkSync(binSrc, linkPath);
      console.log(`✅ Linked omo -> ${linkPath}`);
      console.log(`   Make sure ${binDir} is in your PATH`);
      return;
    } catch (e) {
      // Try next
    }
  }

  console.log(`⚠️  Could not auto-install omo binary. Add this to your PATH manually:`);
  console.log(`   ${path.dirname(binSrc)}`);
}

function main() {
  console.log('🔧 OMO Setup\n');

  ensureDir(CONFIG_DIR);

  const args = process.argv.slice(2);
  const profile = args[0] || 'codex-daily';

  installProfile(profile);
  installBin();

  console.log('\n🎉 Setup complete!');
  console.log(`   Config:  ${TARGET_FILE}`);
  console.log(`   Profile: ${profile}`);
  console.log('\nNext steps:');
  console.log('  omo list        - List all profiles');
  console.log('  omo <profile>   - Switch profile');
  console.log('  omo status      - Check current profile');
}

main();
