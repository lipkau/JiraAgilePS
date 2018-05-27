using System;
using System.Collections.Generic;
using System.Collections;
// using System.Linq;

namespace AtlassianPS
{

    namespace JiraPS
    {

        public enum ProjectTypeKey
        {
            // TODO
            "software"
        }

        namespace Agile
        {

            using AtlassianPS.JiraPS;

            public enum BoardType
            {
                "scrum"
                "kanban"
            }

            public class BoardLocation
            {
                public Int32 ProjectId { get; set; }
                public String Name { get; set; }
                public ..\ProjectTypeKey ProjectTypeKey { get; set; }
                public String avatarURI { get; set; }
                public override string ToString() {
                    return Name;
                }
            }

            public class Board
            {
                public Int32 Id { get; set; }
                public String Name { get; set; }
                public BoardType Type { get; set; }
                public BoardLocation Location { get; set; }
                public String RestURL { get; set; }
                public override string ToString() {
                    return Name;
                }
            }

        }

    }

}
