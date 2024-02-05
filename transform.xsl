<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">

<xsl:key name="pupil-by-class" match="//school_district/pupils/pupil" use="classId"/>

    <xsl:template match="/">
        <html>
            <head>

                <!--PAGE-TITLE-->
                <title>School-District</title>

                <!--BOOTSTRAP-CSS-->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous"/>
           
           </head>
           
            <body>

             <!--CLASS_PAGE-->
                <div>
                    <xsl:for-each select="school_district/classes/class">                   
                        <div class="card border-primary mb-3" style="width:605px">
                            <div class="div-1">
                                
                                <!--CARD_HEADER-->
                                <div class="card-header">
                                    <h3><font color="#060E50"> Klasse: <xsl:value-of select="teacher" /></font></h3>
                                    <font color="#060E50"><xsl:value-of select="grade"/>. Grade</font>
                                    <span class="ms-2 badge bg-primary">
                                        Room: <xsl:value-of select="room"/>
                                    </span>
                                </div>

                                <button type="button" class="btn btn-secondary btn-sm" href="" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#classModal{classId}">
                                    Class-Info
                                </button>
                            </div>
                        </div>
                    </xsl:for-each>
                </div>


              <!--PUPILS-LIST-->
                <xsl:for-each select="//school_district/classes/class">    
                    <div class="modal fade" id="classModal{classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="div-1">
                                    
                                    
                                    <!--BOX_BODY-->
                                    <div class="modal-body">
                                        <h3>Pupils</h3>
                                        <ul class="list-group">                       
                                            <xsl:for-each select="key('pupil-by-class', classId)">
                                                <xsl:sort select="age" data-type="number"/> 
                                                <xsl:choose>
                                                    <xsl:when test="gender='Female'">            
                                                        <li class="list-group-item list-group-item-danger">                                                                                                                                                                                             
                                                            <xsl:value-of select="first_name" /> <xsl:text> </xsl:text>
                                                            <xsl:value-of select="last_name" /> <xsl:text>, </xsl:text>
                                                            <xsl:value-of select="age" /> years old                                                                                           
                                                        </li>
                                                    </xsl:when>                   
                                                    <xsl:otherwise>                                                             
                                                    <li class="list-group-item list-group-item-primary">                                                                                                                                                                              
                                                            <xsl:value-of select="first_name" /> <xsl:text> </xsl:text>
                                                            <xsl:value-of select="last_name" /> <xsl:text>, </xsl:text>
                                                            <xsl:value-of select="age" /> years old                                                                                                
                                                        </li>
                                                    </xsl:otherwise>
                                                </xsl:choose>                         
                                            </xsl:for-each>
                                        </ul>                                        
                                    </div>

                                    <!--BOX_FOOTER-->
                                    <div class="modal-footer">                                    
                                        <button type="button" class="btn btn-secondary" href="" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#classInfo{classId}">
                                            Info
                                        </button>                                      
                                        <font color="#060E50">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </font>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </xsl:for-each>


                <!--INFO_BOX-->
                <xsl:for-each select="//school_district/classes/class">    
                    <div class="modal fade" id="classInfo{classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="div-1">
                                    
                                    <!--BOX_HEADER-->
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Class-Info</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>                                
                                    </div>
                                   
                                   <!--BOX_BODY-->
                                    <div class="modal-body">
                                        <xsl:variable name="pupils" select="key('pupil-by-class', classId)" />
                                        <h6><font color="#060E50">Total: <b><xsl:value-of select="count($pupils)" /></b> Children</font></h6>                                   
                                        <h6><font color="#060E50">Girls: <b><xsl:value-of select="count($pupils[gender='Female'])" /></b></font></h6>
                                        <h6><font color="#060E50">Boys: <b><xsl:value-of select="count($pupils[gender='Male'])" /></b></font></h6>
                                        <h6><font color="#060E50">Average Age: <b><xsl:value-of select='format-number(sum($pupils/age) div count($pupils), "##.00")' /></b></font></h6>
                                    </div>
                                    
                                    <!--BOX_FOOTER-->
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" href="" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#classModal{classId}">Zurück</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>                                  
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </xsl:for-each>                


                <!--BOOTSTRAP-JAVASCRIPT-->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
            
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>