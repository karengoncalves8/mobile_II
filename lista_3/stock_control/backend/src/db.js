import path from 'node:path';
import { open } from 'sqlite';
import sqlite3 from 'sqlite3';

const dbFile = path.resolve(process.cwd(), 'database.sqlite');

export async function createDatabase() {
  const db = await open({
    filename: dbFile,
    driver: sqlite3.Database,
  });

  await db.exec(`
    CREATE TABLE IF NOT EXISTS products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      amount INTEGER NOT NULL CHECK(amount >= 0)
    )
  `);

  return db;
}
