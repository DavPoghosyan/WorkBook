/* Copyright 2010-2013 SpringSource.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @author <a href='mailto:burt@burtbeckwith.training'>Burt Beckwith</a>
 */

includeTargets << new File("$databaseMigrationPluginDir/scripts/_DatabaseMigrationCommon.groovy")

target(dbmRollbackToDateSql: 'Writes SQL to roll back the database to the state it was in at the given date/time version to STDOUT') {
	depends dbmInit

	doAndClose {
		Date date = calculateDate()
		PrintWriter pw
		if (calculateDateFileNameIndex) {
			if (!okToWrite(calculateDateFileNameIndex)) return
			pw = new PrintWriter(new PrintStream(argsList[calculateDateFileNameIndex]))
		}
		else {
			pw = new PrintWriter(System.out)
		}
		liquibase.rollback date, contexts, pw
	}
}

setDefaultTarget dbmRollbackToDateSql